```mermaid
erDiagram
    ARTIST ||--o{ ALBUM : "has"
    ALBUM ||--o{ TRACK : "contains"
    GENRE ||--o{ TRACK : "categorizes"
    TRACK ||--o{ INVOICELINE : "appears in"
    INVOICE ||--o{ INVOICELINE : "has items"
    CUSTOMER ||--o{ INVOICE : "places"

    ARTIST {
        int ArtistId PK
        string Name
    }
    ALBUM {
        int AlbumId PK
        string Title
        int ArtistId FK
    }
    TRACK {
        int TrackId PK
        string Name
        int AlbumId FK
        int GenreId FK
        string Composer
        int Milliseconds
    }
    INVOICE {
        int InvoiceId PK
        int CustomerId FK
        datetime InvoiceDate
        decimal Total
    }
    CUSTOMER {
        int CustomerId PK
        string FirstName
        string LastName
        string Country
        int SupportRepId FK
    }