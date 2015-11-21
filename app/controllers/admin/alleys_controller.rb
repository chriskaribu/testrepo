class Admin::AlleysController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  def index
    @alleys = Alley.all
  end

  def show
  end

  def new
    @alley = Alley.new
  end

  def edit
  end

  def create
    @alley = Alley.new(alley_params)

    respond_to do |format|
      if @alley.save
        format.html { redirect_to admin_alleys_path, notice: 'Bahn wurde erfolgreich angelegt.' }
        format.json { render :show, status: :created, location: @alley }
      else
        format.html { render :new }
        format.json { render json: @alley.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messeges/1
  # PATCH/PUT /messeges/1.json
  def update
    respond_to do |format|
      if @alley.update(alley_params)
        format.html { redirect_to admin_alleys_path, notice: 'Bahn wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @alley }
      else
        format.html { render :edit }
        format.json { render json: @alley.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messeges/1
  # DELETE /messeges/1.json
  def destroy
    @alley.destroy
    respond_to do |format|
      format.html { redirect_to admin_alleys_url, notice: 'Bahn wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @alley = Alley.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alley_params
      params.require(:alley).permit(:name, :active)
    end
end
