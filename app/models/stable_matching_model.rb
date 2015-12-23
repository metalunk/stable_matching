class StableMatchingModel

  # input :men is array of array, that sorted by how :man likes
  #
  # i.e.
  # men : [
  #   :man_id => [
  #     :woman_id,
  #     :woman_id,
  #     ...
  #   ],
  #   :man_id => [...],
  #   ...
  # ]
  def initialize(men, women)
    @men = men
    @women = women
  end

  def calc
  end
end