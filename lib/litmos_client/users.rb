module LitmosClient
  module Users
    def users(params={})
      get("users/details", params)
    end

    def find_user_by_id(id)
      get("users/#{id}")
    rescue NotFound
      nil
    end

    def search_users(value)
      users({"search" => value})
    end

    def create_user(options={})
      raise ArgumentError.new(":user_name is required") if options[:user_name].empty?
      raise ArgumentError.new(":first_name is required") if options[:first_name].empty?
      raise ArgumentError.new(":last_name is required") if options[:last_name].empty?
      raise ArgumentError.new(":email is required") if options[:email].empty?

      params = Hash[ options.map{ |k, v| [k.to_s.split('_').collect(&:capitalize).join, v]} ]

      # params = {
      #   'UserName' => options[:username],
      #   'FirstName' => options[:first_name],
      #   'LastName' => options[:last_name],
      #   'Email' => options[:email],
      #   'DisableMessages' => true,
      #   'IsCustomUsername' => true,
      #   'SkipFirstLogin' => true
      # }

      post("users", params)
    end

    def delete_user(id)
      delete "/users/#{id}"
    end

    def update_user(id, options={})
      put("users/#{id}", params)
    end
  end
end
