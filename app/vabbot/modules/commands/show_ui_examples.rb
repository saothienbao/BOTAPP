require_relative '../../../../app/vabbot/static/sample_elements'
# An example of commands submodule.
module ShowUIExamples
  # State 'module_function' before any method definitions so
  # commands are mixed into Dispatch classes as private methods.
  module_function

  # Commands that showcase main UI elements
  def show_button_tintuc
    UI::FBButtonTemplate.new(SampleElements::BUTTON_TINTUC_TEXT,
                             SampleElements::BUTTON_TINTUC_BUTTONS)
                        .send(@user)
  end

  def show_button_tygia
    UI::FBButtonTemplate.new(SampleElements::BUTTON_TYGIA_TEXT,
                             SampleElements::BUTTON_TYGIA_BUTTONS)
                        .send(@user)
  end

  def show_carousel(image_ratio: nil)
    if image_ratio == :square
      UI::FBCarousel.new(SampleElements::CAROUSEL).square_images.send(@user)
    else
      UI::FBCarousel.new(SampleElements::CAROUSEL).send(@user)
    end
  end

  def send_image
    say "Wait a bit while I pick a nice random image for you"
    img_url = 'https://unsplash.it/600/400?random'
    @message.typing_on if @message
    UI::ImageAttachment.new(img_url).send(@user)
    @message.typing_off if @message
  end
end
