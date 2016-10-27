  if (currentPosition == firstInRange) {
    console.log("First in Range");
    $("#js-previous").addClass("disabled");
  } else if (currentPosition == lastInRange) {
    console.log("Last in Range");
    $("#js-next").addClass("disabled");
  } else {
    $("#js-previous").removeClass("disabled");
    $("#js-next").removeClass("disabled");
  }

  function loadCustomerInfo(id) {
    $('html, body').animate({ scrollTop: 0 }, 'fast');

    // We need to disable the previous and next buttons if there are no more
    // available in that range.  We also need to enable the buttons when we move
    // off of those
    if (currentPosition == firstInRange) {
      console.log("First in Range");
      $("#js-previous").addClass("disabled");
    } else if (currentPosition == lastInRange) {
      console.log("Last in Range");
      $("#js-next").addClass("disabled");
    } else {
      $("#js-previous").removeClass("disabled");
      $("#js-next").removeClass("disabled");
    }


    $.get("/api/v1/ipaddresses/" + id, function(data) {
      $(".current").replaceWith("<a class=\"current\"><i class=\"fa fa-user\"></i> " + data["ip"] + "</a>");

      if (data["customer"] == null) {
        $("#moveBtn").addClass("disabled");
        $("#unassignBtn").addClass("disabled");
        $("#moveBtn").attr("disabled");
        $("#unassignBtn").attr("disabled");

        $("#customer_first_name").val("");
        $("#customer_last_name").val("");
        $("#customer_account_number").val("");

        $("#customer_address_book_attributes_address_1").val("");
        $("#customer_address_book_attributes_address_2").val("");
        $("#customer_address_book_attributes_city").val("");
        $("#customer_address_book_attributes_state").val("");
        $("#customer_address_book_attributes_zipcode").val("");
        $("#customer_email").val("");
        $("#customer_home_phone").val("");
        $("#customer_cell_phone").val("");
        $("#custmer_work_phone").val("");

        $("#customer_company_attributes_name").val("");
        $("#customer_company_attributes_contact_first_name").val("");
        $("#customer_company_attributes_contact_last_name").val("");
        $("#customer_company_attributes_contact_email").val("");
        $("#customer_company_attributes_billing_email").val("");
        $("#customer_company_attributes_company_address_attributes_address_1").val("");
        $("#customer_company_attributes_company_address_attributes_address_2").val("");
        $("#customer_company_attributes_company_address_attributes_city").val("");
        $("#customer_company_attributes_company_address_attributes_state").val("");
        $("#customer_company_attributes_company_address_attributes_zipcode").val("");
        $("#customer_company_attributes_company_address_attributes_main_number").val("");
        $("#customer_company_attributes_company_address_attributes_contact_number").val("");
        $("#customer_company_attributes_company_address_attributes_fax").val("");
        $("#customer_notes").val("");


        $("#widget-title").text("-");

        $("#tdnpButton").replaceWith("<button id=\"tdnpButton\" class=\"btn btn-block btn-secondary disabled\">Disconnect</button>");
      } else {
        class googleMapsAddress {
          constructor(address1, address2, city, state, zipcode) {
            this.address1 = address1;
            this.address2 = address2;
            this.city = city;
            this.state = state;
            this.zipcode = zipcode;
          }

          encodeForGoogleMaps() {
            return this.address1 + " " + this.address2 + ", " + this.city + ", " + this.state + ", " + this.zipcode;
          }
        }

        var customerId = data["customer"]["id"];
        var customer = data["customer"];

        $("#moveBtn").removeClass("disabled");
        $("#unassignBtn").removeClass("disabled");
        $("#moveBtn").removeAttr("disabled");
        $("#unassignBtn").removeAttr("disabled");

        $("#customer_ip_address").val(data["ip"]);
        $("#customer_first_name").val(customer.first_name);
        $("#customer_last_name").val(customer.last_name);
        $("#customer_account_number").val(customer.account_number);

        $("#customer_address_book_attributes_address_1").val(customer.address_book.address_1);
        $("#customer_address_book_attributes_address_2").val(customer.address_book.address_2);
        $("#customer_address_book_attributes_city").val(customer.address_book.city);
        $("#customer_address_book_attributes_state").val(customer.address_book.state);
        $("#customer_address_book_attributes_zipcode").val(customer.address_book.zipcode);

        var customerAddress = new googleMapsAddress(customer.address_book.address_1, customer.address_book.address_2, customer.address_book.city, customer.address_book.state, customer.address_book.zipcode);
        $("#address_map_box").val(customerAddress.encodeForGoogleMaps());
        $("#encode_address").trigger("click");

        if (customer.company == null) {
          $("#customer_company_attributes_name").val("");
          $("#customer_company_attributes_contact_first_name").val("");
          $("#customer_company_attributes_contact_last_name").val("");
          $("#customer_company_attributes_contact_email").val("");
          $("#customer_company_attributes_billing_email").val("");
          $("#customer_company_attributes_company_address_attributes_address_1").val("");
          $("#customer_company_attributes_company_address_attributes_address_2").val("");
          $("#customer_company_attributes_company_address_attributes_city").val("");
          $("#customer_company_attributes_company_address_attributes_state").val("");
          $("#customer_company_attributes_company_address_attributes_zipcode").val("");
          $("#customer_company_attributes_company_address_attributes_main_number").val("");
          $("#customer_company_attributes_company_address_attributes_contact_number").val("");
          $("#customer_company_attributes_company_address_attributes_fax").val("");
        } else {
          $("#customer_company_attributes_name").val(customer.company.name);
          $("#customer_company_attributes_contact_first_name").val(customer.company.contact_first_name);
          $("#customer_company_attributes_contact_last_name").val(customer.company.contact_last_name);
          $("#customer_company_attributes_contact_email").val(customer.company.contact_email);
          $("#customer_company_attributes_billing_email").val(customer.company.billing_email);
          $("#customer_company_attributes_company_address_attributes_address_1").val(customer.company.address_1);
          $("#customer_company_attributes_company_address_attributes_address_2").val(customer.company.address_2);
          $("#customer_company_attributes_company_address_attributes_city").val(customer.company.city);
          $("#customer_company_attributes_company_address_attributes_state").val(customer.company.state);
          $("#customer_company_attributes_company_address_attributes_zipcode").val(customer.company.zipcode);
          $("#customer_company_attributes_company_address_attributes_main_number").val(customer.company.main_number.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));

          if (customer.company.contact_number != null) {
            $("#customer_company_attributes_company_address_attributes_contact_number").val(customer.company.contact_number.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));
          }

          if (customer.company.fax != null) {
            $("#customer_company_attributes_company_address_attributes_fax").val(customer.company.fax.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));
          }

        }

        $("#customer_email").val(customer.email);
        $("#customer_home_phone").val(customer.home_phone.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));

        if (data["customer"]["cell_phone"] != null) {
          $("#customer_cell_phone").val(customer.cell_phone.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));
        }

        if (data["customer"]["work_phone"] != null) {
          $("#custmer_work_phone").val(customer.work_phone.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3'));
        }

        $("#customer_notes").val(customer.notes);

        $("#widget-title").text(customer.name);

        if (data["customer"]["active"] == true) {
          $("#tdnpButton").replaceWith("<a id=\"tdnpButton\" class=\"btn btn-danger btn-block TDNP\" href=\"/customers/" + data["id"] + "/tdnp\">Disconnect</a>");
        } else {
          $("#tdnpButton").replaceWith("<a id=\"tdnpButton\" class=\"btn btn-success btn-block TDNP\" href=\"/customers/" + data["id"] + "/tdnp\">Reconnect</a>");
        }
      }

      var moveLink = "/customers/" + data["id"] + "/move";
      $("moveConfirmBtn").prop("href", moveLink);
      var unassignLink = "/customers/" + data["id"] + "/unassign";
      $("unassignConfirmBtn").prop("href", unassignLink);
    });
  }

  // Navagation through the addresses in the IP Range
  $("#js-previous").on("click", function(id) {
    loadCustomerInfo(currentPosition -= 1);
  });

  $("#js-next").on("click", function() {
    loadCustomerInfo(currentPosition += 1);
  });

  // Form Submitting Stuff
  $('form').submit(function() {
    var data_submitted = $(this).serialize();
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      type: "POST",
      success: function(response) {

      },
      error: function(xhr, textStatus, errorThrown) {

      }
    });

    $('#widget-title').text($("#customer_first_name").val() + " " + $("#customer_last_name").val());

    $('html, body').animate({ scrollTop: 0 }, 'fast');

    return false; // prevents normal behaviour
  });
