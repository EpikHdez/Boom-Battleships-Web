json.inventory @inventories do |inventory|
    json.id inventory.id
    json.quantity inventory.quantity

    json.item do
        json.id inventory.item.id
        json.name inventory.item.name
        json.picture inventory.item.picture
    end
end
