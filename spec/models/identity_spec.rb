require 'spec_helper'

describe Identity do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
end