class HomeController < ApplicationController
  def index
    require('open-uri')
    require('json')
    
    @day = 854
    @get_info = JSON.parse(open("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=#{@day}").read)
    @drw_numbers = []
    
    
    @get_info.each do |k, v|
      @drw_numbers << v if k.include? 'drwtNo'
    end
    
    @drw_numbers.sort!
    
    @bonus_number = @get_info['bnusNo']
    
    @lotto = (1..45).to_a.sample(6).sort
    
    @match_number = @drw_numbers & @lotto
    
    @match_count = @match_number.count
    
    if @match_count == 6
            then @result = '1등입니다!'
        elsif @match_count == 5 && @my_numbers.include?(@bonus_number)
            then @result = '2등입니다!'
        elsif @match_count == 5
            then @result = '3등입니다!'
        elsif @match_count == 4
            then @result = '4등입니다!'
        elsif @match_count == 3
            then @result =  '5등입니다!'
        else @result = '꽝입니다 ㅠㅠ'
    end
    
  end
end
