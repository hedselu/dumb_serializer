module DumbDump
  module Loadable
    def find(id)
      doc = find_in_db(id) #handle error on no result!
      doc_to_object(doc)
    end

    def all
      docs = MongoConnector.client[collection_name].find.to_a
      docs.each_with_object([]) do |doc, array|
        array << doc_to_object(doc)
      end
    end

    private

    def find_in_db(id)
      collection = MongoConnector.client[collection_name]
      collection.find(_id: BSON::ObjectId(id)).to_a.first.to_s
    end

    def doc_to_object(doc)
      build(doc)
    end

    def build(partial)
      return partial unless partial.instance_of?(BSON::Document)
      partial['vars'].each { |name, value| partial['vars'][name] = build(value) }
      klass = class_get(partial['class'])
      build_partial(klass, partial['vars'])
    end

    def build_partial(klass, vars)
      vars.each_with_object(klass.new) do |(key, value), partial|
        partial.instance_variable_set("@#{key}".to_sym, value)
      end
    end

    def class_get(str)
      Object.const_get(str)
    end

    def collection_name
      to_s
    end
  end
end
