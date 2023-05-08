class FollowRequestsController < ApplicationController
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show.html.erb" })
  end

  def create
    @the_follow_request = FollowRequest.new
    @the_follow_request.sender_id = session.fetch(:user_id)
    @the_follow_request.recipient_id = params.fetch("query_recipient_id")

    @recipient_user = User.find_by_id(@the_follow_request.recipient_id)
  
  if @recipient_user.private?
    @the_follow_request.status = "pending"
  else
    @the_follow_request.status = "accepted"
  end

    if @the_follow_request.valid?
      @the_follow_request.save
      redirect_to("/users/#{@recipient_user.username}", { :notice => "Follow request created successfully." })
    else
      redirect_to("/", { :alert => @the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    if @the_follow_request.valid?
      @the_follow_request.save
      redirect_to("/", { :notice => "Follow request updated successfully." })
    else
      redirect_to("/", { :alert => @the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/", { :notice => "Follow request deleted successfully." })
  end
end