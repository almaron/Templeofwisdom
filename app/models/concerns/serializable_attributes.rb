module SerializableAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def serializable_attributes(*args)
      if args[-1].is_a?(Hash)
        options_hash = args.pop
        cond = options_hash[:if] if options_hash[:if].is_a?(Proc)
      end

      cond ||= Proc.new{ |c| true }

      args.each do |attr|
        getter_backup = begin
          self.instance_method(attr)
        rescue
          nil
        end

        define_method attr do
          if cond.call(self)
            self.attrs[attr.to_sym]
          else
            getter_backup.bind(self).call unless getter_backup.nil?
          end
        end

        define_method "#{attr}=" do |value|
          if cond.call(self)
            if self.class.ancestors.include?(ActiveModel::Dirty)
              self.attrs_will_change!
            end
            self.attrs ||= {}
            self.attrs[attr.to_sym] = value
          end
        end
      end
    end
  end
end