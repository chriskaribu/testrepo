class Admin::MeetingsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = Meeting.future
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to admin_meetings_path, notice: 'Termin wurde erfolgreich angelegt.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messeges/1
  # PATCH/PUT /messeges/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to admin_meetings_path, notice: 'Termin wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messeges/1
  # DELETE /messeges/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to admin_meetings_url, notice: 'Termin wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :email, :phone, :start_time, :end_time, :note, :accepted, :ignore_non_accepted, :alley_ids => [])
    end
end
