class HomesController < ApplicationController
  CLIENT_ID = 'iuER08ujqzVYyftPlRd5P8cyQzH0porUKSZitFGk'
  CLIENT_SECRET = 'LnU4mLgF4OfBbQZnouKq2QqRKFilUNubVd7nI91kpdO1ISLCAtx28UvRwZVQ7x7Lb1fi9jT92JqNRpnpcmSlSNKrbgNCWjSyxeYGdX44e6TFglGA6YoqRyLaiAmOeAvJ'

  # before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    # byebug
    # @homes = Home.all
    # gon.my_int = 123456
    # # token = 'GENOMELINKTEST001'
    # code = params[:code]
    # # render html: "hello, world!"
    # byebug
    # res = open(url,
    # "Authorization" => "bearer #{token}") do |f|
    #   f.each_line do |line|
    #       puts line
    #   end
    # end
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    byebug
    code = params[:code] if params[:code]
    begin
      token = JSON.parse(RestClient::Request.execute(method: :post, url: 'https://genomelink.io/oauth/token',
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
        payload: {
          :grant_type => 'authorization_code',
          :code => code,
          :client_id => CLIENT_ID,
          :client_secret => CLIENT_SECRET,
          :redirect_uri => 'https://shrouded-caverns-50791.herokuapp.com/homes/show'
        }))['access_token']
    rescue RestClient::ExceptionWithResponse => e
      e.response
      # byebug
      @error_message = 'abcde'
      flash[:error] = 'Invalid login, please try again.'
      redirect_to action: 'index'
      return
    end
    byebug

    url = 'https://genomelink.io/v1/reports/eye-color?population=european'
    res = RestClient.get url, { :Authorization => "bearer #{token}" }
    byebug
  end

  # GET /homes/new
  def new
    # @home = Home.new
    # RestClient::Request.execute(method: :get, url: 'https://genomelink.io/oauth/authorize?response_type=code&client_id=iuER08ujqzVYyftPlRd5P8cyQzH0porUKSZitFGk&redirect_uri=http://127.0.0.1:3000/homes&scope=report:eye-color')
    redirect_to "https://genomelink.io/oauth/authorize?response_type=code&client_id=#{CLIENT_ID}&redirect_uri=https://shrouded-caverns-50791.herokuapp.com/homes/show&scope=report:eye-color"
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    # @home = Home.new(home_params)
    #
    # respond_to do |format|
    #   if @home.save
    #     format.html { redirect_to @home, notice: 'Home was successfully created.' }
    #     format.json { render :show, status: :created, location: @home }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @home.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    # respond_to do |format|
    #   if @home.update(home_params)
    #     format.html { redirect_to @home, notice: 'Home was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @home }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @home.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    # @home.destroy
    # respond_to do |format|
    #   format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      # @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      # params.require(:home).permit(:name, :password)
    end
end
