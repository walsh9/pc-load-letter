module PcLoadLetterViewHelper
  def error_helper
    if @errors
      render partial: "partials/error", collection: @errors
    end
  end
end