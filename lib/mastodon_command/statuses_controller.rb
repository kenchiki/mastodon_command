# モンキーパッチ
class Api::V1::StatusesController < Api::BaseController

  def create
    status = MastodonCommand.convert_toot(status_params[:status])
    @status = PostStatusService.new.call(current_user.account,
                                         status,
                                         status_params[:in_reply_to_id].blank? ? nil : Status.find(status_params[:in_reply_to_id]),
                                         media_ids: status_params[:media_ids],
                                         sensitive: status_params[:sensitive],
                                         spoiler_text: status_params[:spoiler_text],
                                         visibility: status_params[:visibility],
                                         application: doorkeeper_token.application,
                                         idempotency: request.headers['Idempotency-Key'])

    render :show
  end

  private
  # 使用されているprivateメソッドも入れておかないとモンキーパッチが動かなかった
  def status_params
    params.permit(:status, :in_reply_to_id, :sensitive, :spoiler_text, :visibility, media_ids: [])
  end
end
