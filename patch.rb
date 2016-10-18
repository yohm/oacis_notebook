module JupyterHelper

  def self.make_html_for_model( obj, table_contents, path )
    header = "<h2>#{obj.class}</h2>"
    tags = table_contents.map do |key,val|
      "<tr><th>#{key}</th><td>#{val}</td></tr>"
    end
    link = "<a href=http://localhost:3000#{path} target=\"_blank\" >link</a>"
    header + "<table>" + tags.join + "</table>" + link
  end
end

Simulator.class_eval do

  # with_results: keys of results. can be either nil, string, or array of strings.
  def parameter_sets_in_dataframe(where: nil, with_results: nil)
    pss = parameter_sets.asc(:id)
    pss = pss.where(where) if where
    param_keys = parameter_definitions.map(&:key)
    rows = pss.map do |ps|
      mapped = param_keys.map {|key| ps.v[key] }
      mapped += Array(with_results).map {|r| ps.average_result(r) }
      mapped
    end
    ids = pss.map(&:id)

    keys = param_keys + Array(with_results)

    Daru::DataFrame.rows( rows, order: keys, index: ids )
  end

  def to_html
    keys = [:id,:name,:command,:description]
    table = keys.map {|key| [ key, self.send(key) ] }
    path = Rails.application.routes.url_helpers.simulator_path(self)
    JupyterHelper.make_html_for_model( self, table, path)
  end
end

ParameterSet.class_eval do

  def to_html
    keys = [:id,:parameters]
    table = keys.map {|key| [ key, self.send(key) ] }
    path = Rails.application.routes.url_helpers.parameter_set_path(self)
    JupyterHelper.make_html_for_model( self, table, path)
  end
end

Run.class_eval do

  def to_html
    keys = [:id, :status, :submitted_to, :result]
    table = keys.map {|key| [ key, self.send(key) ] }
    table[2] = ["submitted host", submitted_to.try(:name)]

    path = Rails.application.routes.url_helpers.run_path(self)
    JupyterHelper.make_html_for_model( self, table, path)
  end
end

Analyzer.class_eval do

  def to_html
    keys = [:id,:simulator,:name,:command,:description]
    table = keys.map {|key| [ key, self.send(key) ] }
    table[1][1] = simulator.name

    path = Rails.application.routes.url_helpers.analyzer_path(self)
    JupyterHelper.make_html_for_model( self, table, path)
  end
end

Analysis.class_eval do

  def to_html
    keys = [:id, :analyzer,:status, :submitted_to,:result]
    table = keys.map {|key| [ key, self.send(key) ] }
    table[1] = ["analyzer", analyzer.name ]
    table[3] = ["submitted host", submitted_to.try(:name) ]

    path = Rails.application.routes.url_helpers.analysis_path(self)
    JupyterHelper.make_html_for_model( self, table, path)
  end
end
