module MoTaiKhoan
  module_function

  OPEN_ACCOUNT_GENDER = UI::QuickReplies.build(%w[Ông Mr], %w[Bà Ms])
  OPEN_ACCOUNT_ID = UI::QuickReplies.build(%w[CMND CMND], %w[Hộ_Chiếu PASSPORT], %w[CCCD CCCD])
  OPEN_ACCOUNT_MARRIAGE = UI::QuickReplies.build(%w[Độc_Thân SINGLE], %w[Đã_Kết_Hôn MARRIAGE],%w[Khác OTHER])
  OPEN_ACCOUNT_CAREER = UI::QuickReplies.build(%w[Công_Chức OFFICER], %w[Nhân_Viên_Văn_Phòng STAFF], %w[Tự_Doanh BUSINESS], %w[Khác OTHER])

  def start_motaikhoan
    if @message.quick_reply == 'START_MOTAIKHOAN' || @message.text =~ /yes/i
      say 'Xin chào ! Vui lòng cho biết danh xưng của Quý khách', quick_replies: OPEN_ACCOUNT_GENDER
      next_command :handle_gender_and_ask_fullname
    else
      say "Thực hiện lại sau. Tạm biệt!"
      stop_thread
    end
  end

  def handle_gender_and_ask_fullname
      @user.answers[:gender] = @message.text
      say 'Vui lòng nhập họ và tên đầy đủ của Quý khách'
      next_command :handle_name_and_ask_email
  end

  def handle_name_and_ask_email
      @user.answers[:fullname] = @message.text
      say 'Vui lòng nhập cho biết địa chỉ email của Quý khách'
      next_command :handle_email_and_ask_phone
  end

  def handle_email_and_ask_phone
    @user.answers[:email] = @message.text
    say 'Cho biết số điện thoại của Quý khách'
    next_command :handle_phone_no_and_ask_nationality
  end

  def handle_phone_no_and_ask_nationality
    @user.answers[:phone_no] = @message.text
    say 'Cho biết quốc tịch của Quý khách'
    next_command :handle_nationality_and_ask_id_doc_type
  end

  def handle_nationality_and_ask_id_doc_type
    @user.answers[:nationality] = @message.text
    say 'Loại giấy tờ tùy thân của Quý khách là gì', quick_replies: OPEN_ACCOUNT_ID
    next_command :handle_id_doc_type_and_ask_id_no
  end

  def handle_id_doc_type_and_ask_id_no
    @user.answers[:id_doc_type] = @message.text
    say 'Nhập số CMND/Hộ chiếu'
    next_command :handle_id_no_and_ask_date_of_issue
  end

  def handle_id_no_and_ask_date_of_issue
    @user.answers[:id_no] = @message.text
    say 'Nhập ngày cấp CMND/Hộ Chiếu'
    next_command :handle_date_of_issue_and_ask_place_of_issue
  end

  def handle_date_of_issue_and_ask_place_of_issue
    @user.answers[:id_issue_date] = @message.text
    say 'Nhập nơi cấp CMND/Hộ chiếu'
    next_command :handle_place_of_issue_and_ask_marriage_status
  end

  def handle_place_of_issue_and_ask_marriage_status
    @user.answers[:id_issue_place] = @message.text
    say 'Vui lòng cho biết tình trạng hôn nhân của Quý khách', quick_replies: OPEN_ACCOUNT_MARRIAGE
    next_command :handle_marriage_status_and_ask_date_of_birth
  end

  def handle_marriage_status_and_ask_date_of_birth
    @user.answers[:marriage_status] = @message.text
    say 'Vui lòng cho biết ngày tháng năm sinh'
    next_command :handle_date_of_birth_and_ask_country_home_town
  end

  def handle_date_of_birth_and_ask_country_home_town
    @user.answers[:dob] = @message.text
    say 'Cho biết nguyên quán của Quý khách'
    next_command :handle_hometown_and_ask_career
  end

  def handle_hometown_and_ask_career
    @user.answers[:hometown] = @message.text
    say 'Cho biết nghể nghiệp của Quý khách', quick_replies: OPEN_ACCOUNT_CAREER
    next_command :handle_career_and_ask_for_permanent_address
  end

  def handle_career_and_ask_for_permanent_address
    @user.answers[:permanent_add] = @message.text
    say 'Cho biết địa chỉ hiện tại của Quý khách'
    next_command :handle_current_add_and_stop
  end

  def handle_current_add_and_stop
    @user.answers[:current_add] = @message.text
    stop_motaikhoan
  end

  def stop_motaikhoan
    stop_thread
    show_results
    @user.answers = {}
  end

  def show_results
    say "Sau đây là nội dung quý khách đã nhập: \n"
    fullname = @user.answers.fetch(:fullname, 'N/A')
    gender = @user.answers.fetch(:gender, 'N/A')
    acc_bene_name = @user.answers.fetch(:acc_bene_name, 'N/A')
    transf_amount = @user.answers.fetch(:transf_amount, 'N/A')
    trans_contents = @user.answers.fetch(:trans_contents, 'N/A')
    text = "Hình thức chuyển khoản: #{types_of_transfer} \n" \
           "Số tài khoản người nhận: #{acc_bene_no} \n" \
           "Tên người nhận: #{acc_bene_name} \n" \
           "Số tiền chuyển: #{transf_amount} \n" \
           "Nội dung chuyển: #{trans_contents}"
    say text
    say 'Cảm ơn quý khách!'
  end


end