module RoomsHelper
  
    # 最新メッセージのデータを取得して表示するメソッド
  def most_new_direct_message_preview(room)
    # 最新メッセージのデータを取得する
    direct_message = room.direct_messages.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    direct_message = direct_message[0]
    # メッセージの有無を判定
    if direct_message.present?
      # メッセージがあれば内容を表示
      tag.p "#{direct_message.message}", class: "dm_list__content__link__box__message"
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.p "[ まだメッセージはありません ]", class: "dm_list__content__link__box__message"
    end
  end
  
    # 相手ユーザー名を取得して表示するメソッド
  def opponent_user(room)
    # 中間テーブルから相手ユーザーのデータを取得
    entry = room.entries.where.not(user_id: current_user)
    # 相手ユーザーの名前を取得
    first_name = entry[0].user.first_name
    # 名前を表示
    tag.p "#{first_name}", class: "dm_list__content__link__box__name"
  end
  
    # 相手ユーザー名を取得して表示するメソッド
  def opponent_user_last_name(room)
    # 中間テーブルから相手ユーザーのデータを取得
    entry = room.entries.where.not(user_id: current_user)
    # 相手ユーザーの名前を取得
    last_name = entry[0].user.last_name
    # 名前を表示
    tag.p "#{last_name}", class: "dm_list__content__link__box__name"
  end
end
