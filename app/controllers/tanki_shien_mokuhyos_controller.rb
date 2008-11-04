class TankiShienMokuhyosController < ApplicationController
  # GET /tanki_shien_mokuhyos
  # GET /tanki_shien_mokuhyos.xml
  def index
    @tanki_shien_mokuhyos = TankiShienMokuhyo.find(:all)
        
    @options_for_mokuhyo = ShienKeikaku.find(:all).map{|i| [i.boy.name, i.id]}    
    @options_for_mokuhyo.insert 0,["…児童を選択…" , '']
    
    @title = '一覧'
    #viewのｾﾚｸﾀｰでﾌﾞﾗﾝｸの設定が出来ないためﾃﾞﾌｫﾙﾄでﾘｽﾄ1番目の"…児童を選択…"が表示されShienKeikakuのIDはnilとなり検索に失敗する
    #そのままｻﾌﾞﾐｯﾄﾎﾞﾀﾝが押されるとname spaceの演算でエラーとなる
    #一度対象支援計画表（その児童名）を選択したらそのまま選択状態を維持したままｶﾃｺﾞﾘｰの切替をできることが必要
    #params[:shien_keikaku_id]はviewのｾﾚｸﾀｰで選択した値（存在する支援計画ｼｰﾄのID）
    #一人の児童が2枚以上の支援計画ｼｰﾄを持っている場合は@options_for_mokuhyoの選択ﾘｽﾄを調整する必要がある？
    if params[:shien_keikaku_id] and params[:cat]
        @tanki_shien_mokuhyos = TankiShienMokuhyo.shien_keikaku_id(params[:shien_keikaku_id]).category(params[:cat])
        @title = ShienKeikaku.find(params[:shien_keikaku_id]).boy.name
    elsif params[:shien_keikaku_id]
        @tanki_shien_mokuhyos = TankiShienMokuhyo.shien_keikaku_id(params[:shien_keikaku_id])
        @title = ShienKeikaku.find(params[:shien_keikaku_id]).boy.name        
    elsif params[:cat]
        @tanki_shien_mokuhyos = TankiShienMokuhyo.cat(params[:cat])
        #@tanki_shien_mokuhyos = TankiShienMokuhyo.find(:all, :conditions =>[ "shien_keikaku_id = ?", params[:shien_keikaku_id]] )
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tanki_shien_mokuhyos }
    end
  end

  # GET /tanki_shien_mokuhyos/1
  # GET /tanki_shien_mokuhyos/1.xml
  def show
    @tanki_shien_mokuhyo = TankiShienMokuhyo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tanki_shien_mokuhyo }
    end
  end

  # GET /tanki_shien_mokuhyos/new
  # GET /tanki_shien_mokuhyos/new.xml
  def new
    @tanki_shien_mokuhyo = TankiShienMokuhyo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tanki_shien_mokuhyo }
    end
  end

  # GET /tanki_shien_mokuhyos/1/edit
  def edit
    @tanki_shien_mokuhyo = TankiShienMokuhyo.find(params[:id])
  end

  # POST /tanki_shien_mokuhyos
  # POST /tanki_shien_mokuhyos.xml
  def create
    @tanki_shien_mokuhyo = TankiShienMokuhyo.new(params[:tanki_shien_mokuhyo])

    respond_to do |format|
      if @tanki_shien_mokuhyo.save
        flash[:notice] = 'TankiShienMokuhyo was successfully created.'
        format.html { redirect_to(@tanki_shien_mokuhyo) }
        format.xml  { render :xml => @tanki_shien_mokuhyo, :status => :created, :location => @tanki_shien_mokuhyo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tanki_shien_mokuhyo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tanki_shien_mokuhyos/1
  # PUT /tanki_shien_mokuhyos/1.xml
  def update
    @tanki_shien_mokuhyo = TankiShienMokuhyo.find(params[:id])

    respond_to do |format|
      if @tanki_shien_mokuhyo.update_attributes(params[:tanki_shien_mokuhyo])
        flash[:notice] = 'TankiShienMokuhyo was successfully updated.'
        format.html { redirect_to(@tanki_shien_mokuhyo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tanki_shien_mokuhyo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tanki_shien_mokuhyos/1
  # DELETE /tanki_shien_mokuhyos/1.xml
  def destroy
    @tanki_shien_mokuhyo = TankiShienMokuhyo.find(params[:id])
    @tanki_shien_mokuhyo.destroy

    respond_to do |format|
      format.html { redirect_to(tanki_shien_mokuhyos_url) }
      format.xml  { head :ok }
    end
  end
end