class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update]
  
  def index
    @members = Member.all
  end
  
  def show
    @members = []
    if params[:search].present?
      friends_member_id = @member.friends_list.pluck(:id)
      member_ids = [@member.id, friends_member_id].flatten
      @members = Member.where.not(id: member_ids).where("description LIKE (?)", "%#{params[:search]}%")
    end
  end

  def new
    @member  = Member.new
    @friends = @member.friends_list.pluck(:id)
  end

  def edit
    @friends = @member.friends_list.pluck(:id)
  end

  def create
    @member = Member.new(member_params)
    respond_to do |format|
      if @member.save
        WebContentWorker.perform_async(@member.id)
        format.html { redirect_to edit_member_url(@member), notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      friend_ids = params[:member] && params[:member][:friend_ids] && params[:member][:friend_ids].reject(&:empty?)
      if @member.update(member_params)
        @member.update_friends_list(friend_ids)
        WebContentWorker.perform_async(@member.id)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:name, :website_url, :shortening, :website_headings, :friend_ids, :description)
    end
end
