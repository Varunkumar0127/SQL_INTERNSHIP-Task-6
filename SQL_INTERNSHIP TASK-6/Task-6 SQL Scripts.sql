##Correlated Subquery latest booking date is after 2024-06-01.
SELECT g.GuestID, g.Name
FROM guests g
WHERE (
    SELECT MAX(b.CheckInDate)
    FROM bookings b
    WHERE b.GuestID = g.GuestID
) > '2024-06-01';

 ##Scaler Subquery Total Payments for Each Guest
SELECT g.GuestID, g.Name,
       (SELECT ROUND(SUM(p.AmountPaid), 2)
        FROM payments p
        JOIN bookings b ON b.BookingID = p.BookingID
        WHERE b.GuestID = g.GuestID) AS TotalPaid
FROM guests g;

##IN — Guests Who Used a Deluxe Room
SELECT g.GuestID, g.Name
FROM guests g
WHERE g.GuestID IN (
    SELECT b.GuestID
    FROM bookings b
    JOIN rooms r ON r.RoomID = b.RoomID
    WHERE r.RoomType = 'Deluxe'
);

##EXISTS — Guests With At Least One Payment
SELECT g.GuestID, g.Name
FROM guests g
WHERE EXISTS (
    SELECT 1
    FROM bookings b
    JOIN payments p ON p.BookingID = b.BookingID
    WHERE b.GuestID = g.GuestID
);

##NOT EXISTS — Guests Who Never Booked a Room
SELECT g.GuestID, g.Name
FROM guests g
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.GuestID = g.GuestID
);


