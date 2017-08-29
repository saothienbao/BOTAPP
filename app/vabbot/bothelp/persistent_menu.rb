# rubocop:disable all
module VABBotBase
  # Enables persistent menu for your bot
  class PersistentMenu
    def self.enable
      # Design your persistent menu here:
      Facebook::Messenger::Profile.set({
        persistent_menu: [
          {
            locale: 'default',
            # If this option is set to true,
            # user will only be able to interact with bot
            # through the persistent menu
            # (composing a message will be disabled)
            composer_input_disabled: false,
                        call_to_actions: [
              {
                type: 'nested',
                title: 'Việt Á Bank',
                call_to_actions: [
                  {
                    title: 'Tầm Nhìn Và Sứ Mệnh',
                    type: 'postback',
                    payload: 'CAROUSEL'
                  },
                  {
                    title: 'Tin Tức',
                    type: 'postback',
                    payload: 'BUTTON_TINTUC'
                  },
                  {
                    title: 'Xem Tỷ Giá',
                    type: 'postback',
                    payload: 'BUTTON_TYGIA'
                  }
                ]
              },
              {
                type: 'postback',
                title: 'Dịch Vụ',
                payload: 'LOCATION'
              },
              {
                type: 'postback',
                title: 'Tiện Ích Chuyển Khoản',
                payload: 'CHUYENKHOAN'
              }
            ]
          }
        ]
        }, access_token: ENV['ACCESS_TOKEN'])
    end
  end
end
