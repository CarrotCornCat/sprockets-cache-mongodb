module Sprockets
  module Cache
    # A simple MongoDB cache store.
    #
    #     environment.cache = Sprockets::Cache::MongoDBStore.new($mongo)
    #
    class MongoDBStore

      def initialize(mongo_conn, db_name = 'sprockets')
        @mongo = ::Mongo::Grid.new( mongo_conn.db(db_name) )
      end

      # Lookup value in cache
      def [](key)
        sanitized_key = sanitize_key(key)
        return unless @mongo.exist?(:filename => sanitized_key)
        object = @mongo.get sanitized_key
        data   = object.read
        Marshal.load data if data
      end

      # Save value to cache
      def []=(key, value)
        @mongo.put  Marshal.dump(value),
                    :_id          => sanitize_key(key),
                    :filename     => sanitize_key(key),
                    :content_type => "application/x-ruby-marshal"
        value
      end

      private

      def sanitize_key(key)
        ::Digest::SHA1.hexdigest key
      end

    end
  end
end
