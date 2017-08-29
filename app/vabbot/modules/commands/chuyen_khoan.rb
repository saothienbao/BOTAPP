module Chuyen_Khoan

  module_function

  TYPE_OF_TRANSFER = ['INT','EXT','FAST']
  TRANSFER =  UI::QuickReplies.build(%w[NỘI-BỘ INT], %w[LIÊN-NGÂN-HÀNG EXT], %w[CHUYỂN-NHANH FAST])

  def start_chuyenkhoan
    if @message.quick_reply == 'START_CHUYENKHOAN' || @message.text =~ /yes/i
    say 'Xin chào ! Vui lòng chọn hình thức chuyển khoản', quick_replies: TRANSFER
    next_command :handle_type_transfer_and_ask_acc_bene_no
    else
      say "Thực hiện lại sau. Tạm biệt!"
      stop_thread
    end
  end

  def start_chuyenkhoan_again
    say 'Vui lòng chọn hình thức chuyển khoản', quick_replies: TRANSFER
    next_command :handle_type_transfer_and_ask_acc_bene_no
  end

  def handle_type_transfer_and_ask_acc_bene_no
    @user.answers[:type_of_transfer] = @message.text
    type_tf = @message.quick_reply
    puts type_tf
    if TYPE_OF_TRANSFER.exclude?type_tf
      say 'Bạn chọn chưa đúng. Vui lòng thực hiện lại!'
      start_chuyenkhoan_again
    else
      say 'Vui lòng nhập số tài khoản người nhận'
      next_command :handle_acc_bene_no_and_ask_acc_bene_name
    end
  end

  def handle_acc_bene_no_and_ask_acc_bene_name
    @user.answers[:acc_bene_no] = @message.text
    #gọi ws để kiểm tra
    say 'Vui lòng nhập tên người nhận'
    next_command :handle_acc_bene_name_and_ask_amount_transfer
  end

  def handle_acc_bene_name_and_ask_amount_transfer
    @user.answers[:acc_bene_name] = @message.text
    say 'Vui lòng cho biết số tiền cần chuyển'
    next_command :handle_amount_transfer_and_ask_contents
  end

  def handle_amount_transfer_and_ask_contents
    @user.answers[:transf_amount] = @message.text
    say 'Vui lòng cho biết nội dung chuyển tiền'
    next_command :handle_contents_and_confirm
  end

  def handle_contents_and_confirm
    @user.answers[:trans_contents] = @message.text
    stop_chuyenkhoan
  end

  def stop_chuyenkhoan
    stop_thread
    show_results
    @user.answers = {}
  end

  def show_results
    say "Sau đây là nội dung quý khách đã nhập: \n"
    types_of_transfer = @user.answers.fetch(:type_of_transfer, 'N/A')
    acc_bene_no = @user.answers.fetch(:acc_bene_no, 'N/A')
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

  # NOTE: A way to enforce sanity checks (repeat for each sequential command)
  def fall_back
    say 'Xin lỗi! Chúng tôi không biết lựa chọn của bạn. Xin vui lòng thử lại' unless text_message?
    return false unless !text_message? || stop_word_used?('Stop')
    stop_chuyenkhoan
    puts 'Fallback triggered!'
    true # to trigger return from the caller on 'and return'
  end

  # specify stop word
  def stop_word_used?(word)
    !(@message.text =~ /#{word.downcase}/i).nil?
  end
end
