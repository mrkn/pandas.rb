require 'pandas' unless defined?(Pandas)

module Pandas
  class DataFrame
    def [](key)
      key = PyCall::List.new(key) if key.is_a?(Array)
      super
    end

    def to_narray
      to_numpy.to_narray
    end

    def to_iruby_mimebundle(include: [], exclude: [])
      include = ["text/html", "text/latex", "text/plain"] if include.empty?
      include -= exclude unless exclude.empty?
      include.map { |mime|
        data = case mime
               when "text/html"
                 _repr_html_
               when "text/latex"
                 _repr_latex_
               when "text/plain"
                 if respond_to?(:_repr_pretty_)
                   _repr_pretty_
                 else
                   __repr__
                 end
               end
        [mime, data] if data
      }.compact.to_h
    end
  end
end
