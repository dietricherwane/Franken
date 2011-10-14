class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_creation?(parameters)
    if @parameters[:trash].split.first!=(nil)
    if parameters[:trash].split.first.casecmp('tchat').eql?(0)
      true
    end
    end
  end

  def area_registration?(parameters)
    if @parameters[:trash].split.first!=(nil)
    if parameters[:trash].split.first.casecmp('a?').eql?(0)
      true
    end
    end
  end

  def search_user?(parameters)
    @param = parameters[:trash].split
    if @param[0].to_i.is_a?(Integer) && @param[1].to_i.is_a?(Integer) && @param[0].to_i!=0 && @param[1].to_i!=0
      true
    end
  end

  def find_gender(parameters)
    @gender = parameters.gender
    if @gender.eql?('f')
      'h'
    else
      'f'
    end
  end

  def send_message?(parameters)
    if @parameters[:trash].split.first!=(nil)
    if (parameters[:trash].split[0].size > 2) && (/\?$/ =~ parameters[:trash].split[0])!=(nil)
      true
    end
    end
  end

  def send_message_to_valid_user?(parameters)
    if User.find_by_username(parameters[:trash].split[0].sub('?', ''))!=nil
      true
    end
  end

  def get_receiver(parameters)

  end

  def registration?(parameters)
    if User.find_by_phone_number(parameters).nil?
      true #means that the phone number is not inside the database
    end
  end

  def user_registered?(parameters)
    if User.find_by_phone_number(parameters).eql?(nil)
      false
    else
      true
    end
  end

  def correct_registration_message?(parameters)
    @param = parameters.split
    if @param.size.eql?(4) && @param[0].casecmp('tchat').eql?(0)  && (@param[2].casecmp('f').eql?(0) || @param[2].casecmp('h').eql?(0)) && @param[3].to_i!=0
      true
    end
  end

  def username_doesnt_exists?(parameters)
    if User.find_by_username(parameters.split[1]).nil? #we do not split again because he has already been in "correct_registration_message?" function  and we are continuing with the same variable
      true
    end
  end

  def send_error_message
    redirect_to(root_path, :notice => 'Error!')
  end

end
