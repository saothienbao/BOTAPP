require 'unidecoder'
module NLPHelper
  include Unidecoder
  include StringExtensions
  module_function

  BASE_VERBS_CONST = ['CHUYEN KHOAN', 'THANH TOAN HOA DON', 'MO TAI KHOAN', 'NAP TIEN', 'TRA TIEN','XEM THONG TIN','HUY']

  BASE_CONJ_CONST = ['TRONG', 'NGOAI', 'LIEN', 'DEN', 'NHANH']
  BASE_OBJS_CONST = ['NGAN HANG', 'HE THONG', 'NOI BO', 'THONG TIN',
                     'HOA DON', 'TIEN DIEN', 'TIEN NUOC','INTERNET','CUOC INTERNET','CUOC DIEN THOAI', 'DIEN THOAI', 'TAI KHOAN',
                     'TAI KHOAN THANH TOAN', 'TAI KHOAN TIET KIEM']


  def findFunction(strMsg)
    name = strMsg.to_ascii.upcase
    result =""
    BASE_VERBS_CONST.each do |a|
      if name.include?a
        result = a
        break
      end
    end
    return result
  end
end
