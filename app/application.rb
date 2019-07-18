class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # DISPLAY ALL AVAILABLE ITEMS
    if req.path.match(/items/)
      @@items.each { |item| resp.write "#{item}\n" }

    # DISPLAY ALL ITEMS IN CART
    elsif req.path.match(/cart/)
      @@cart.length > 0 ? @@cart.each { |item| resp.write "#{item}\n" } : resp.write("Your cart is empty")

    # ADD ITEM TO CART
    elsif req.path.match(/add/)
      desired_item = req.params["item"]
      resp.write add_to_cart(desired_item)

    # SEARCH FOR ITEM
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    # INVALID PATH
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_to_cart(desired_item)
    if @@items.include?(desired_item)
      @@cart << desired_item
      return "added #{desired_item}"
    else
      return "We don't have that item"
    end
  end
end
