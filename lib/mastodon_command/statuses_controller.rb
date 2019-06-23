module ApiV1StatusesControllerPatch
  def create
    status = MastodonCommand.convert_toot(status_params[:status])
    @status = PostStatusService.new.call(current_user.account,
                                         text: status,
                                         thread: status_params[:in_reply_to_id].blank? ? nil : Status.find(status_params[:in_reply_to_id]),
                                         media_ids: status_params[:media_ids],
                                         sensitive: status_params[:sensitive],
                                         spoiler_text: status_params[:spoiler_text],
                                         visibility: status_params[:visibility],
                                         scheduled_at: status_params[:scheduled_at],
                                         application: doorkeeper_token.application,
                                         poll: status_params[:poll],
                                         idempotency: request.headers['Idempotency-Key'])

    render json: @status, serializer: @status.is_a?(ScheduledStatus) ? REST::ScheduledStatusSerializer : REST::StatusSerializer
  end
end
