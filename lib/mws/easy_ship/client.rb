# frozen_string_literal: true

require 'peddler/client'

module MWS
  module EasyShip
    # With the Easy Ship API section, you can build applications that help sellers in India manage and ship their Amazon Easy Ship orders. Your Amazon Easy Ship applications can:
    # Get available pickup slots.
    # Schedule, reschedule, and cancel pickups.
    # Print labels, invoices, and warranties.

    class Client < ::Peddler::Client
      self.version = '2018-09-01'
      self.path = "/EasyShip/#{version}"

      # The ListPickupSlots operation returns time slots for Amazon Easy Ship package pickup, based on the package dimensions and package weight that the seller specifies.
      #
      # @see http://docs.developer.amazonservices.com/en_IN/easy_ship/EasyShip_ListPickupSlots.html
      # @param [String] marketplace_id
      # @param [String] amazon_order_id
      # @param [Struct, Hash] package_dimensions
      # @param [Struct, Hash] package_weight
      # @return [Peddler::XMLParser]
      def list_pickup_slots(marketplace_id, amazon_order_id, package_dimensions, package_weight)
        operation('ListPickupSlots')
          .add('MarketplaceId' => marketplace_id, 'AmazonOrderId' => amazon_order_id, 
               'PackageDimensions' => package_dimensions, 'PackageWeight' => package_weight)

        run
      end

      # Calling the CreateScheduledPackage operation does the following:

      # Schedules an Amazon Easy Ship package pickup slot. This is a window of time when the seller can expect their package to be picked up for delivery to the buyer.
      # Marks the Amazon Easy Ship order status as WaitingForPickup. You can check the status of Amazon Easy Ship orders by calling the ListOrders operation of the Orders API section and examining the EasyShipShipmentStatus response element.
      # Generates a shipping label and an invoice. Calling CreateScheduledPackage also generates a warranty document if you specify a SerialNumber value. To get these documents, see How to get invoice, shipping label, and warranty documents
      #
      # @see http://docs.developer.amazonservices.com/en_IN/easy_ship/EasyShip_CreateScheduledPackage.html
      # @param [String] marketplace_id
      # @param [String] amazon_order_id
      # @param [Struct, Hash] package_request_details
      # @return [Peddler::XMLParser]
      def create_scheduled_package(next_token)
        operation('CreateScheduledPackage')
          .add('MarketplaceId' => marketplace_id, 'AmazonOrderId' => amazon_order_id, 'PackageRequestDetails' => package_request_details)

        run
      end

      # The UpdateScheduledPackages operation updates the pickup slot of an existing scheduled package. Pass in the ScheduledPackageId value for the scheduled package that the seller wants to change, along with a new SlotId value for the desired scheduled pickup slot
      #
      # @see http://docs.developer.amazonservices.com/en_IN/easy_ship/EasyShip_UpdateScheduledPackages.html
      # @param [String] marketplace_id
      # @param [Struct, Hash] scheduled_package_update_details_list
      # @return [Peddler::XMLParser]
      def update_scheduled_packages
        operation('UpdateScheduledPackages')
          .add('MarketplaceId' => marketplace_id, 'ScheduledPackageUpdateDetailsList' => scheduled_package_update_details_list)
        run
      end

      # The GetScheduledPackage operation returns information about a scheduled package, including dimensions, weight, pickup slot information, invoice and item information, and status.
      #
      # @see http://docs.developer.amazonservices.com/en_IN/easy_ship/EasyShip_GetScheduledPackage.html
      # @param [String] marketplace_id
      # @param [Struct, Hash] scheduled_package_id
      # @return [Peddler::XMLParser]
      def get_scheduled_package
        operation('GetScheduledPackage')
          .add('MarketplaceId' => marketplace_id, 'ScheduledPackageId' => scheduled_package_id)
        run
      end

      # The GetServiceStatus operation returns the operational status of the Easy Ship API section of Amazon Marketplace Web Service. Status values are GREEN, YELLOW, and RED.
      #
      # @see http://docs.developer.amazonservices.com/en_IN/easy_ship/EasyShip_GetServiceStatus.html
      # @return [Peddler::XMLParser]
      def get_service_status
        operation('GetServiceStatus')
        run
      end

    end
  end
end
