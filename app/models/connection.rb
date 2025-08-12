class Connection < ApplicationRecord
  def self.find_connect(filter,capi_1, capi_2)
    if filter == "friends"
      connection_type_id = ConnectionType.find_by_name("friends").id
    end
    if filter == "spouse"
      connection_type_id = ConnectionType.find_by_name("married").id
    end
    connect = Connection.where("(capi_1 = :capi_1 AND capi_2 = :capi_2 OR capi_2 = :capi_1 AND capi_1 = :capi_2) AND connection_type_id = :connection_type_id ", capi_1: capi_1, capi_2: capi_2, connection_type_id: connection_type_id )
    return connect
  end

  def self.find_with_status(capi_id, status)
    return Connection.where("(capi_1 = :id OR capi_2 = :id) AND status = :status", id: capi_id, status: status)
  end

  def self.find_connect_by_capi_id(capi_id)
    return Connection.where("(capi_1 = :id OR capi_2 = :id)", id: capi_id)

  end

end
