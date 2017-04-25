class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
      # @itemが保存されていない場合、先に@itemを保存する。
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      
      @item = Item.new(read(results.first))
      @item.save
    end
    
    case params[:type]
      when "Want" then
        current_user.want(@item)
        flash[:success] = "商品をWantしました。"
      when "Have" then
        current_user.have(@item)
        flash[:success] = "商品をHaveしました。"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    case params[:type]
      when "Want" then
        current_user.unwant(@item)
        flash[:success] = "商品のWantを解除しました。"
      when "Have" then
        current_user.unhave(@item)
        flash[:success] = "商品のHaveを解除しました。"
    end
    
    redirect_back(fallback_location: root_path)
  end
end
