function change_quantity(operation) {
    var input = $(":input[id*='quantity']");
    var current_value = parseInt(input.val());

    switch(operation) {
        case 'plus':
            input.val(++current_value);
            break;
        case 'minus':
            if (current_value !== 1) {
                input.val(--current_value);
            }
            break;
        default:
            console.log( 'Wrong operation' );
    }
}