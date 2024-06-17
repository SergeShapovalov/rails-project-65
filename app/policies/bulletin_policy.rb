# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || edit? || admin?
  end

  def new?
    user
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def moderate?
    edit?
  end

  def archive?
    edit?
  end

  def create?
    new?
  end
end
