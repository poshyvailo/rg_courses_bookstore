$(':checkbox').on('change', function () {
    $('#remove-account').find('input[type="submit"]')
        .prop('disabled', !$(':checkbox:checked').length);
}).change();