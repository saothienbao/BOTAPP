module SampleElements
  CAROUSEL = [
    {
      title: 'Giới Thiệu Về Việt Á',
      image_url: 'https://vietabank.com.vn/Portals/0/HTML/GIOITHIEU/banner%20tam%20nhin.jpg',
      subtitle: "Tầm nhìn Việt Á Bank",
      default_action: {
        type: 'web_url',
        url: 'https://vietabank.com.vn/vi/tam-nhin-su-menh_t365c147n2787'
      },
      buttons: [
        {
          type: :web_url,
          url: 'https://vietabank.com.vn',
          title: 'Đến Trang Chủ'
        }
      ]
    }
  ].freeze

  BUTTON_TINTUC_TEXT = "Tin tức mới từ Viêt Á Bank".freeze
  BUTTON_TINTUC_BUTTONS = [
    {
      type: :web_url,
      url: 'https://vietabank.com.vn/tin-tuc-va-su-kien_t283c148',
      title: "Tin Tức"
    }
  ].freeze

  BUTTON_TYGIA_TEXT = "Tỷ giá ngoại tệ và vàng".freeze
  BUTTON_TYGIA_BUTTONS = [
      type: :web_url,
      url: 'https://vietabank.com.vn/chuyen-muc-khac/ty-gia_t388c0',
      title: "Xem Tỷ Giá"
  ].freeze

end
