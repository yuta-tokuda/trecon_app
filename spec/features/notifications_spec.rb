require 'rails_helper'

RSpec.feature 'Notifications', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:user)
    @third_user = FactoryBot.create(:user)
    @note = FactoryBot.create(:note, :public_note, created_by_user: @user)
  end

  scenario 'ノートを投稿したら自分以外のユーザーに通知が行く' do
    login_as @second_user
    visit root_path
    expect(@second_user.passive_notifications.count).to eq 1
    expect(page).to have_selector '.badge', text: 1
    expect(page).to have_selector '.notification-detail', text: "#{ @user.full_name }さんがノートを公開しました。「#{ @note.title }」"
    logout @second_user

    login_as @third_user
    visit root_path
    expect(@third_user.passive_notifications.count).to eq 1
    expect(page).to have_selector '.badge', text: 1
    expect(page).to have_selector '.notification-detail', text: "#{ @user.full_name }さんがノートを公開しました。「#{ @note.title }」"
  end

  describe '一つのノートにコメント通知一つだけの場合' do
    before do
      Notification.destroy_all
      comment = FactoryBot.create(:user_note_comment, editor: @note.created_by_user, reply_user: @second_user, note: @note)
      FactoryBot.create(:notification, :comment_notification, active_user: @second_user, passive_user: @note.created_by_user, comment: comment, note: @note)
      login_as @user
      visit root_path
    end

    scenario 'ノートに初めてコメント投稿したらそのノートの投稿者に通知が行く', js: true do
      expect(@user.passive_notifications.count).to eq 1
      expect(page).to have_selector '.badge', text: 1
      find('.bell').click
      expect(page).to have_selector '.notification-detail', text: "#{ @second_user.full_name }さんが「#{ @note.title }」にコメントしました。"
      find('.notification-detail', text: "#{ @second_user.full_name }さんが「#{ @note.title }」にコメントしました。").click
      expect(page).to_not have_selector '.badge', text: 1
    end

    scenario 'コメントに対して返信したらそのコメントの受信者に通知が行く', js: true do
      find('.bell').click
      find('.notification-detail', text: "#{ @second_user.full_name }さんが「#{ @note.title }」にコメントしました。").click
      find('.reply-btn').click
      fill_in 'content_0', with: 'テストコメントに返信'
      find('.create_comment').click
      logout @user

      login_as @second_user
      visit root_path
      sleep 1
      expect(@second_user.passive_notifications.where(kind: 'comment').count).to eq 1
      expect(page).to have_selector '.badge', text: 1
      find('.bell').click
      expect(page).to have_selector '.notification-detail', text: "#{ @user.full_name }さんが「#{ @note.title }」にコメントしました。"
    end
  end

  describe '一つのノートに複数のコメント通知がある場合' do
    before do
      Notification.destroy_all
      comment = FactoryBot.create(:user_note_comment, editor: @note.created_by_user, reply_user: @second_user, note: @note)
      FactoryBot.create(:notification, :comment_notification, active_user: @second_user, passive_user: @note.created_by_user, comment: comment, note: @note)
      comment = FactoryBot.create(:user_note_comment, editor: @note.created_by_user, reply_user: @third_user, note: @note)
      FactoryBot.create(:notification, :comment_notification, active_user: @third_user, passive_user: @note.created_by_user, comment: comment, note: @note)
      login_as @user
      visit root_path
    end

    scenario '一つの通知から遷移するとそのノートの通知が全て消える。', js: true do
      expect(@user.passive_notifications.count).to eq 2
      expect(page).to have_selector '.badge', text: 2
      find('.bell').click
      page.all('.comment-notification')[0].click
      expect(page).to_not have_selector '.badge', text: 2
      expect(@user.passive_notifications.count).to eq 0
    end

    context 'どの通知から遷移しても最も古いコメントの上部に案内がくる', js: true do
      scenario '最も古いコメントの通知から遷移する' do
        find('.bell').click
        page.all('.comment-notification').last.click
        expect(find('.comments')).to have_css 'div:first-child.unread-line'
      end

      scenario '最も新しいコメントの通知から遷移する', js: true do
        find('.bell').click
        page.first('.comment-notification').click
        expect(find('.comments')).to have_css 'div:first-child.unread-line'
      end
    end
  end
end
