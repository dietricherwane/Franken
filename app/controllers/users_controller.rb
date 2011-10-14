class UsersController < ApplicationController
  
  def index
   @user = User.new
  end

  def dispatcher
    @parameters = params[:user]
      if area_registration?(@parameters) #the first word is a? or A? and the user is registered, it means that the user wants to register an area
        redirect_to register_area_path(@parameters)
      end
      if user_creation?(@parameters)
        redirect_to create_user_path(@parameters)
      end
      if search_user?(@parameters)
        redirect_to search_user_path(@parameters)
      end
      if send_message?(@parameters)
        if send_message_to_valid_user?(@parameters)
          redirect_to send_message_path(@parameters)
        else
          send_error_message #means that the user doesn't exists
        end
        #redirect_to send_message_path(@parameters)
      #else
        #send_error_message
      end
  end

  def create_user
    if registration?(params[:phone_number])
      if correct_registration_message?(params[:trash])
        if username_doesnt_exists?(params[:trash])
          User.create(:username => params[:trash].split[1], :phone_number => params[:phone_number], :gender => params[:trash].split[2], :age => params[:trash].split[3].to_i)
          redirect_to(root_path, :notice => 'You are now registered and your username is <'+params[:trash].split[1]+'>')
        else
          send_error_message #means that the username already exists || send back suggestions?
        end
      else
        send_error_message #means that the sms is not on the correct form || send back message  containing  an example of correct registration message?
      end
    else
      send_error_message #means that the phone number is already inside the database || you're already registered and your username is <gatling> delete it before creating another account
    end    
  end

  def register_area
    if user_registered?(params[:phone_number])
      @user = User.find_by_phone_number(params[:phone_number])
      @area = params[:trash].sub('a? ', '').sub('A? ', '').sub('a?', '').sub('A?', '')
      @user.update_attributes(:area => @area)
      redirect_to(root_path, :notice => 'your area has been updated to <'+@area+'>')   
    else
      send_error_message
    end
  end

  def search_user
    if user_registered?(params[:phone_number])
      @gender = find_gender(User.find_by_phone_number(params[:phone_number]))
      @var = params[:trash].split
      @age_min = @var[0].to_i
      @age_max = @var[1].to_i
      @tab_color = true #background color for the table
      if @var.size.eql?(2)
        @users = User.find(:all, :conditions => { :age => @age_min..@age_max, :gender => @gender })
      else
        @var.slice!(0)
        @var.slice!(0)
        @var = @var.join(' ')
        @users = User.find(:all, :conditions => { :age => @age_min..@age_max, :gender => @gender, :area => @var})
      end
    else
      send_error_message
    end
  end

  def send_message
    @receiver = User.find_by_username(params[:trash].split[0].sub('?', '')).phone_number
    @sender = User.find_by_phone_number(params[:phone_number]).id
    Message.create(:receiver => @receiver, :user_id => @sender, :content => params[:trash].sub(params[:trash].split[0], ''))
    redirect_to(root_path, :notice => 'Your message has been sent to <'+User.find_by_username(params[:trash].split[0].sub('?', '')).username+'>')
  end

  def list_users
    @users = User.all
  end

  def new
    @user = User.new
  end

end
