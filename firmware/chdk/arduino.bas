@title interfaz basica para arduino
print "esperando disparo..."
do
do
x = get_usb_power
until x > 50
print "disparo!"
shoot
sleep 2000
until is_key "set"
end
