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
      set_cookie(:guest)
      redirect_to event_path(@event)
    else
      flash.now[:alert] = '閲覧パスワードを入力してください'
      render :new_guest, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:id])
  end

  def event_params
    form_params = params.require(:event).permit(:title, :password)
    form_params = form_params.merge(user_id: current_user.id) if user_signed_in?
    form_params
  end

  def move_to_new_guest
    # 主催者用cookieを持っていればパスワード画面に遷移しない
    event_host_ids = cookies.signed[:host]
    return if event_host_ids && event_host_ids.include?(@event.id)

    # 参加者用cookieを持っていればパスワード画面に遷移しない
    event_guest_ids = cookies.signed[:guest]
    return if event_guest_ids && event_guest_ids.include?(@event.id)
    # 作成したユーザーであればパスワード画面に遷移しない
    return if user_signed_in? && @event.user && current_user.id == @event.user_id

    # 上記を満たさない場合パスワード画面に遷移する
    redirect_to "/events/#{@event.uid}/sign_in"
  end
end
