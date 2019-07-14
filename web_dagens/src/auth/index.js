import auth0 from 'auth0-js';
import config from './config.json';

const expiresAt = 'expiresAt';
const idToken = 'idToken';
const profile = 'profile';

class Auth {
  constructor() {
    console.log(config);

    this.auth0 = new auth0.WebAuth({
      // the following three lines MUST be updated
      ...config,
      audience: `https://${config.domain}/userinfo`,
      redirectUri: `${window.location.origin}/callback`,
      responseType: 'id_token',
      scope: 'openid profile email'
    });

    this.getProfile = this.getProfile.bind(this);
    this.handleAuthentication = this.handleAuthentication.bind(this);
    this.isAuthenticated = this.isAuthenticated.bind(this);
    this.signIn = this.signIn.bind(this);
    this.signOut = this.signOut.bind(this);
  }

  getProfile() {
    return JSON.parse(localStorage.getItem(profile) || '{}');
  }

  getIdToken() {
    return localStorage.getItem(idToken);
  }

  isAuthenticated() {
    return new Date().getTime() < localStorage.getItem(expiresAt);
  }

  signIn() {
    this.auth0.authorize();
  }

  handleAuthentication() {
    return new Promise((resolve, reject) => {
      this.auth0.parseHash((err, authResult) => {
        if (err) return reject(err);
        if (!authResult || !authResult.idToken) {
          return reject(err);
        }

        localStorage.setItem(idToken, authResult.idToken);
        localStorage.setItem(profile, JSON.stringify(authResult.idTokenPayload));
        localStorage.setItem(expiresAt, authResult.idTokenPayload.exp * 1000);
        resolve();
      });
    })
  }

  signOut() {
    // clear id token, profile, and expiration
    localStorage.setItem(idToken, null);
    localStorage.setItem(profile, null);
    localStorage.setItem(expiresAt, null);
  }
}

const auth0Client = new Auth();

export default auth0Client;