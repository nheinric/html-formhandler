package HTML::FormHandler::Widget::Field::RadioGroup;
# ABSTRACT: radio group rendering widget

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Field::Role::SelectedOption';
with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $id = $self->id;
    my $output = " <br />";
    my $index  = 0;

    my $fif = $result->fif;
    foreach my $option ( @{ $self->options } ) {
        my $value = $option->{value};
        $output .= qq{<label for="$id.$index"><input type="radio" value="}
            . $self->html_filter($value) . '" name="'
            . $self->html_name . qq{" id="$id.$index"};
        $output .= ' checked="checked"'
            if $fif eq $value;
        $output .= $self->_add_html_attributes;
        $output .= ' />';
        $output .= $self->html_filter($option->{label}) . '</label><br />';
        $index++;
    }
    return $self->wrap_field( $result, $output );
}

1;
