module MastodonCommand
  module StatusesControllerPatch
    def create
      status = MastodonCommand.convert_toot(status_params[:status])
      @status = PostStatusService.new.call(
        current_user.account,
        text: status,
        thread: @thread,
        media_ids: status_params[:media_ids],
        sensitive: status_params[:sensitive],
        spoiler_text: status_params[:spoiler_text],
        visibility: status_params[:visibility],
        language: status_params[:language],
        scheduled_at: status_params[:scheduled_at],
        application: doorkeeper_token.application,
        poll: status_params[:poll],
        idempotency: request.headers['Idempotency-Key'],
        with_rate_limit: true
      )

      render json: @status, serializer: @status.is_a?(ScheduledStatus) ? REST::ScheduledStatusSerializer : REST::StatusSerializer
    end
  end
end
