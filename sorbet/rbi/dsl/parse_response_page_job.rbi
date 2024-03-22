# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ParseResponsePageJob`.
# Please instead update this file by running `bin/tapioca dsl ParseResponsePageJob`.

class ParseResponsePageJob
  class << self
    sig do
      params(
        response_page: ::ResponsePage,
        block: T.nilable(T.proc.params(job: ParseResponsePageJob).void)
      ).returns(T.any(ParseResponsePageJob, FalseClass))
    end
    def perform_later(response_page:, &block); end

    sig { params(response_page: ::ResponsePage).void }
    def perform_now(response_page:); end
  end
end