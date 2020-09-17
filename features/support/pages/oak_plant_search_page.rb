class OakPlantSearchPage
  include PageObject

  page_url 'https://plants.oaklandnursery.com/12130001'

  text_field( :search_plant_edit_box, id: 'NetPS-KeywordInput')
  button(:submit,id: 'NetPSSubmit')
  links(:plant_names,class: /NetPS-ResultsP(2|)Link$/)
  checkbox(:choose_first_result, id: 'CheckmP1')
  link(:select_wish_list, text: 'View My Wish List')
  div(:wish_list_header, id: 'NetPS-mPTitle')

  div(:plant_details, class: 'NetPS-ResultsDataSub')

  def search_plant plant_name
    # @browser.text_field(id: 'NetPS-KeywordInput').set plant_name
    # also as
    # search_plant_edit_box_element.set plant_name
        self.search_plant_edit_box = plant_name
    # both the above lines are same
    # @browser.button(id: 'NetPSSubmit').click
    # above line can be written as
    submit_element.click
  end


  def get_all_plant_names
#@browser.link(class: 'NetPS-ResultsP2Link').text
#   @browser.links(class: /NetPS-ResultsP(2|)Link$/).map(&:text)
#     all_results = []
#     plant_names_elements.each do |each_results|
#       all_results << each_result.text
#     end
#     all_results
plant_names_elements.map(&:text)
  end

  def verify_plant_search_is_correct plant_name
    get_all_plant_names.each do|each_name|
      p "verifying the plant - #{each_name} has correct values - #{plant_name}"
      fail "plant name #{each_name} is not related to #{plant_name} "unless each_name.include? plant_name
    end
  end

  def verify_no_of_plant_search_results
    fail "no of results are more than 10" unless plant_names_elements.count <= 10
  end

  def add_plant_to_wishlist
    # @browser.checkbox(id: 'CheckmP1').set
    unless choose_first_result_element.checked?
    choose_first_result_element.when_present(60).set
    end
    # fail "check box is not selected" unless choose_first_result_element.checked?
    select_wish_list_element.click
    fail "you are not on the wish list page" unless wish_list_header_element.text.eql? 'My Wish List'
  end

  def verify_wishlist_has_plant first_plant_name_from_search_page
    first_plant_name_from_wishlist_page = get_all_plant_names.first
    fail "Wishlist doesnt has the correct plant" unless first_plant_name_from_search_page == first_plant_name_from_wishlist_page
  end
#
#   def update_wishlist_quantity new_quantity
#     @browser.text_field(id: 'QtymP1').set new_quantity
#     # @browser.link(text: 'Update My Wish List').click
#     sleep 3
#   end
#
#   def verify_wishlist_quantity_has_updated exp_quantity
#     new_quantity = @browser.text_field(id: 'QtymP1').value
#     fail "#{exp_quantity} is not same as #{new_quantity.to-i}"unless exp_quantity.eql? new_quantity.to_i
#   end
#
#   def empty_wishlist
#     @browser.checkbox(id:'CheckmP1').click if @browser.checkbox(id:CheckmP1).checked?
#     @browser.link(text:'Update My Wish List').click
#     sleep 3
#   end
#
#   def verify_wishlist_is_empty
#     fail"Wish List Empty message is not shown - #{@browser.div(class: 'NetPS-MessageBlock').strong.text}"
#   end
#
  def get_plant_info
    plant_info_hash = {}
    plant_details_element.text.split("\n").each do |plant_detail_info|
      #plant_detail_info.split(": ")[0]
      plant_info_hash[plant_detail_info.split(": ")[0]] = plant_detail_info.split(": ")[1].strip
    end
    plant_info_hash
  end
end