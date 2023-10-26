class Capibara < ApplicationRecord
  def self.find_friends(id)
    connection_type_id = ConnectionType.find_by_name("friends").id
    connections_friends = Connection.where("(capi_1 = :id OR capi_2 = :id) AND connection_type_id = :connection_type_id AND status = 'approved'", id: id, connection_type_id: connection_type_id)

    return Capibara.where(id: connections_friends.map { |connection| connection.capi_1 == id ? connection.capi_2 : connection.capi_1 }) if connections_friends.present?
  end

  def self.find_spouse(id)
    connection_type_id = ConnectionType.find_by_name("married").id
    spouse_connection = Connection.where("(capi_1 = :id OR capi_2 = :id) AND connection_type_id = :connection_type_id AND status = 'approved'", id: id, connection_type_id: connection_type_id).first

    if spouse_connection.present?
      spouse_id = spouse_connection.capi_1 == id ? spouse_connection.capi_2 : spouse_connection.capi_1
      return Capibara.find_by(id: spouse_id)
    end
  end

  def self.find_requests(id)
    connections = Connection.where("(capi_1 = :id OR capi_2 = :id) AND status = 'proposed'", id: id)

    return Capibara.where(id: connections.map { |connection| connection.capi_1 == id ? connection.capi_2 : connection.capi_1 }) if connections.present?
  end

end
