class StableMatchingModel

  # input :men is hash of array, which sorted by :man's preference for each :woman
  #
  # i.e.
  # men : [
  #   :man => [
  #     :woman,
  #     :woman,
  #     ...
  #   ],
  #   :man => [...],
  #   ...
  # ]
  def initialize(men, women)
    @men = men
    @women = women
  end

  SAFETY_BREAK = 1000

  def match
    # engage_list : [
    #   :man : :woman,
    #   ...
    # ]
    engage_list = {}
    single_mens_preference_list = Marshal.load(Marshal.dump(@men))
    loop = 0

    catch(:break) do
      while !single_mens_preference_list.blank? do
        single_mens_preference_list.each do |man, mans_preference_list|
          next if engage_list.has_key? man
          engage_list = propose man, mans_preference_list.first, engage_list
          single_mens_preference_list = update_preference_list single_mens_preference_list, man
          throw :break if engage_list.size == @men.size
        end

        loop += 1
        if loop >= SAFETY_BREAK
          break
        end
      end
    end

    sorted_engage_list = {}
    @men.each do |man, tmp|
      sorted_engage_list[man] = engage_list[man]
    end
    sorted_engage_list
  end

  private

  def propose (man, woman, engage_list)
    engaged_man = engage_list.key woman
    if engaged_man.nil?
      engage_list[man] = woman
    else
      if @women[woman].index(man) < @women[woman].index(engaged_man)
        engage_list.delete engaged_man
        engage_list[man] = woman
      end
    end
    engage_list
  end

  # man can propose only one time for each woman
  def update_preference_list (preference_list, man)
    preference_list[man].shift
    preference_list.delete man if preference_list[man].blank?
    preference_list
  end
end
