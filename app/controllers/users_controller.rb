class UsersController < ApplicationController
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie, :index] })

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    if session.fetch(:user_id) != nil
      user = params.fetch("path_id")
      matching_user = User.where({ :username => user }).first
      @the_user = matching_user

      follow_requests = FollowRequest.all
      list_of_follow_request = follow_requests.order({ :created_at => :desc })
      @followers = list_of_follow_request.where({ :recipient_id => @current_user.id })

      render({ :template => "users/show.html.erb" })
    else
      redirect_to("/", { :alert => "You need to sign in first." })
    end
  end

  def update
    user = params.fetch("path_id")
    @the_user = User.where({ :id => user }).at(0)

    @the_user.user_id = params.fetch("query_user_id")
    @the_user.photo_id = params.fetch("query_photo_id")

    if @the_user.valid?
      @the_user.save
      redirect_to("/likes/#{@the_user.id}", { :notice => "Like updated successfully." })
    else
      redirect_to("/likes/#{@the_user.id}", { :alert => @the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    user = params.fetch("path_id")
    @the_user = User.where({ :id => user }).at(0)

    @the_user.destroy

    redirect_to("/likes", { :notice => "Like deleted successfully." })
  end

  def liked_photos
    user = params.fetch("username")
    matching_user = User.where({ :username => user }).first
    @the_user = matching_user

    @photos = @current_user.photos

    render("users/liked_photos.html.erb")
  end

  def discover
    user = params.fetch("username")
    matching_user = User.where({ :username => user }).first
    @the_user = matching_user

    render("users/discover.html.erb")
  end

  def feed
    username = params.fetch("username")
    @the_user = User.where({ :username => username }).first
    @accepted_follow_request = @current_user.sent_follow_requests.where({ :status => "accepted" })

    render({ :template => "users/feed.html.erb" })
  end
end
