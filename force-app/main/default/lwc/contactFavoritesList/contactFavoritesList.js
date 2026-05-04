import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

// LWC to display a list of contacts with the ability to mark them as favorites.
export default class ContactFavoritesList extends LightningElement {
    contacts = [];
    favorites = new Set();
    isLoading = false;
    error = undefined;

    // Fetch contacts from Apex controller
    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = [];
            this.console.error('Error fetching contacts:', error);
        }
    }

    get favoritesList() {
        return Array.from(this.favorites);
    }

    // Computed property to determine if there are any favorites
    get hasFavorites() {
        return this.favorites.size > 0;
    }
    get contactsWithFavoriteStatus() {
        return this.contacts.map(contact => ({
            ...contact,
            isFavorite: this.favorites.has(contact.Id)
        }));
    }

    toggleFavorite(event) {
        event.preventDefault();
        const contactId = event.currentTarget.dataset.contactId;
        
        if (this.favorites.has(contactId)) {
            this.favorites.delete(contactId);
        } else {
            this.favorites.add(contactId);
            this.favoritesList.push(contactId); // Add to favorites list for display
        }

        // Force re-render by creating a new array
        this.contacts = [...this.contacts];
        this.favoritesList = [...this.favoritesList];
    }
    // Helper method to get contact's full name or initials
    getContactName(contact) {
        const firstName = contact.FirstName || '';
        const lastName = contact.LastName || '';
        const fullName = `${firstName} ${lastName}`.trim();
        const initials = `${firstName.charAt(0) || ''}${lastName.charAt(0) || ''}`.toUpperCase();
        return fullName || initials || 'Unknown Contact';  
        return `${firstName} ${lastName}`.trim();
    }

    // Helper method to get contact's initials for avatar
    getContactInitials(contact) {
        const firstName = contact.FirstName || '';
        const lastName = contact.LastName || '';
        return `${firstName.charAt(0) || ''}${lastName.charAt(0) || ''}`.toUpperCase();
    }
    get noContactsMessage() {
        return this.isLoading ? 'Loading contacts...' : 'No contacts found';
    }
}
