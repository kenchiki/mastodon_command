module MastodonCommand
  module StatusesControllerPatch
    def create
      status = MastodonCommand.convert_toot(status_params[:status])
      @status = PostStatusService.new.call(
        current_user.account,
        text: status,
        thread: @thread,
        quoted_status: @quoted_status,
        quote_approval_policy: quote_approval_policy,
        media_ids: status_params[:media_ids],
        sensitive: status_params[:sensitive],
        spoiler_text: status_params[:spoiler_text],
        visibility: status_params[:visibility],
        language: status_params[:language],
        scheduled_at: status_params[:scheduled_at],
        application: doorkeeper_token.application,
        poll: status_params[:poll],
        allowed_mentions: status_params[:allowed_mentions],
        idempotency: request.headers['Idempotency-Key'],
        with_rate_limit: true
      )

      render json: @status, serializer: serializer_for_status
    rescue PostStatusService::UnexpectedMentionsError => e
      render json: unexpected_accounts_error_json(e), status: 422
    end
  end
end
