class EventsController < ApplicationController
  before_action :set_event, only: %i[show new_guest create_guest]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.valid?
      @event.save
      Host.create(event_id: @event.id)
      redirect_to "/events/#{@event.uid}/hosts/#{@event.host.uid}/info"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    move_to_new_guest if @event.password_digest
  end

  def new_guest; end

  def create_guest
    password = params[:password]
    if @event.authenticate(password)
      set_guest_cookie
      redirect_to event_path(@event)
    else
      flash.now[:alert] = '閲覧パスワードを入力してください'
      render :new_guest
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:id])
  end

  def event_params
    form_params = params.require(:event).permit(:title, :password)
    form_params = form_params.merge(user_id: current_user.id) if user_signed_in?
  end

  def set_guest_cookie
    # cookieを取得
    event_ids = cookies.signed[:guest]
    if event_ids
      # cookieを既に持っている場合
      # cookieから存在しないeventを取り除く
      ids = []
      event_ids.each do |id|
        ids << id if Event.find_by(id:) && id != @event.id
      end
      # 作成したeventを加えたcookieを渡す
      ids << @event.id
      cookies.signed[:guest] = { value: ids, expires: 1.year.from_now }
    else
      # cookieを持っていない場合
      # 作成したeventのcookieを渡す
      cookies.signed[:guest] = { value: [@event.id], expires: 1.year.from_now }
    end
  end

  def move_to_new_guest
    # 主催者用cookieを持っていればパスワード画面に遷移しない
    event_host_ids = cookies.signed[:host]
    return if event_host_ids && event_host_ids.include?(@event.id)

    # 参加者用cookieを持っていればパスワード画面に遷移しない
    event_guest_ids = cookies.signed[:guest]
    return if event_guest_ids && event_guest_ids.include?(@event.id)
    # 作成したユーザーであればパスワード画面に遷移しない
    return if user_signed_in? && @event.user && current_user.id = @event.user_id

    # 上記を満たさない場合パスワード画面に遷移する
    redirect_to "/events/#{@event.uid}/sign_in"
  end
end
