import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactFavoritesList extends LightningElement {
    contacts = [];
    favorites = [];
    isLoading = false;
    error = undefined;

    // Fetch contacts from Apex controller
    @wire(getContacts)
    wiredContacts({ error, data }) {
        this.isLoading = true;

        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = [];
            console.error('Error fetching contacts:', error);
        }
        this.isLoading = false;
    }

    get favoritesList() {
        return this.favorites;
    }

    // Computed property to determine if there are any favorites
    get hasFavorites() {
        return this.favorites.length > 0;
    }
    get contactsWithFavoriteStatus() {
        return this.contacts.map(contact => ({
            ...contact,
            isFavorite: this.favorites.has(contact.Id),
            favoriteButtonClass: this.favorites.has(contact.Id)
                ? 'favorite-button favorite-active'
                : 'favorite-button'
        }));
    }

    toggleFavorite(event) {
        event.preventDefault();

        const contactId = event.currentTarget.dataset.contactId;

        if (this.favorites.includes(contactId)) {
            this.favorites = this.favorites.filter(
                favoriteId => favoriteId !== contactId
            );
        } else {
            this.favorites = [...this.favorites, contactId];
        }
    }
    // Helper method to get contact's full name or initials
    getContactName(contact) {
        const firstName = contact.FirstName || '';
        const lastName = contact.LastName || '';
        const fullName = `${firstName} ${lastName}`.trim();
        const initials = `${firstName.charAt(0) || ''}${lastName.charAt(0) || ''}`.toUpperCase();
        return fullName || initials || 'Unknown Contact';
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