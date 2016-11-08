class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    p ">>>>>>>>>>>>>>>>>>>>>>", campaign_params, ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    @campaign.save
  end

  private
    def campaign_params
      params.require(:campaign).permit(:title, :description)
    end
end
