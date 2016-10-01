class Simulator

  def parameter_sets_in_dataframe(where: nil)
    pss = parameter_sets.asc(:id)
    pss = pss.where(where) if where
    keys = parameter_definitions.map(&:key)
    rows = pss.map do |ps|
      keys.map {|key| ps.v[key] }
    end
    ids = pss.map(&:id)

    Daru::DataFrame.rows( rows, order: keys, index: ids )
  end
end
